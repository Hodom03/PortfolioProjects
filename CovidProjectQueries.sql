--Looking at world death rate compared to total cases
CREATE VIEW WorldDeathPercentage AS
SELECT 
	SUM(CAST(new_cases AS INT)) AS total_cases, 
	SUM(CAST(new_deaths AS INT)) AS total_deaths, 
	SUM(CAST(new_deaths AS INT))/SUM(new_Cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL 


CREATE VIEW PercentPopulationVaccinated AS
SELECT 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations,
	SUM(cast(vac.new_vaccinations as int)) 
OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date	
WHERE dea.continent IS NOT NULL


-- Looking at total deaths per continent
CREATE VIEW TotalDeathsPerContinent AS
SELECT 
	location, 
	SUM(cast(new_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location


-- Looking at the highest recorded infection rate per location
CREATE VIEW PercentPopulationInfected AS 
SELECT
	Location, 
	Population, MAX(total_cases) as HighestInfectionCount,  
	Max((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY Location, Population


-- Looking at the rolling percentage of infection rates by day per location
CREATE VIEW RollingInfectionRates AS
SELECT 
	Location, 
	Population,date, 
	MAX(total_cases) as HighestInfectionCount,  
	Max((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY Location, Population, date
