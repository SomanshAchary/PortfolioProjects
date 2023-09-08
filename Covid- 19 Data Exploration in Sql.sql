/* Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types */

-- Select *
SELECT *
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 3, 4;

-- Select Data that we are going to be starting with
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2;

-- Total Cases vs Total Deaths (Shows likelihood of dying if you contract Covid in India)
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE location = 'India'
  AND continent IS NOT NULL 
ORDER BY 1, 2;

-- Total Cases vs Population (Shows what percentage of population infected with Covid)
SELECT Location, date, Population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
WHERE location = 'India'
ORDER BY 1, 2;

-- Countries with Highest Infection Rate compared to Population
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
WHERE location = 'India'
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;

-- Countries with Highest Death Count per Population
SELECT Location, MAX(CAST(Total_deaths AS SIGNED)) AS TotalDeathCount
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- BREAKING THINGS DOWN BY CONTINENT
-- Showing continents with the highest death count per population
SELECT continent, MAX(CAST(Total_deaths AS SIGNED)) AS TotalDeathCount
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS SIGNED)) AS total_deaths, (SUM(CAST(new_deaths AS SIGNED))/SUM(New_Cases))*100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2;

-- Total Population vs Vaccinations (Shows Percentage of Population that has received at least one Covid Vaccine)
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
   , SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject.CovidDeaths dea
JOIN PortfolioProject.CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2, 3;

-- Using CTE to perform Calculation on Partition By in previous query
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
       , SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
    FROM PortfolioProject.CovidDeaths dea
    JOIN PortfolioProject.CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL 
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac;

-- Using Temp Table to perform Calculation on Partition By in previous query
DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TEMPORARY TABLE PercentPopulationVaccinated (
    Continent VARCHAR(255),
    Location VARCHAR(255),
    Date DATETIME,
    Population DECIMAL(18, 2),
    New_vaccinations DECIMAL(18, 2),
    RollingPeopleVaccinated DECIMAL(18, 2)
);

INSERT INTO PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
   , SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject.CovidDeaths dea
JOIN PortfolioProject.CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PercentPopulationVaccinated;

-- Creating View to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
   , SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject.CovidDeaths dea
JOIN PortfolioProject.CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
