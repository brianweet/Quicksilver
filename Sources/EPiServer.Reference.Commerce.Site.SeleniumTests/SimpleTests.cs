using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Remote;
using System;
using Xunit;

namespace EPiServer.Reference.Commerce.Site.SeleniumTests
{
    public static class SimpleTests
    {
        [Theory]
        [InlineData("Firefox")]
        public static void CanReachStartpage(string browserName)
        {
            var url = "http://quicksilver-appveyor-do-not-break-test-dns.westeurope.azurecontainer.io";
            using (var driver = CreateWebDriver(browserName))
            {
                driver.Navigate().GoToUrl(url);
                Assert.StartsWith("Start", driver.Title);
            }
        }

        [Theory]
        [InlineData("Firefox")]
        public static void CanFindHeading(string browserName)
        {
            var url = "http://quicksilver-appveyor-do-not-break-test-dns.westeurope.azurecontainer.io";
            using (var driver = CreateWebDriver(browserName))
            {
                driver.Navigate().GoToUrl(url);
                var siteLogo = driver.FindElement(By.CssSelector("h1.site-logo a"));
                var text = siteLogo.GetAttribute("textContent");
                Assert.StartsWith("Quicksilver", text);
            }
        }

        private static IWebDriver CreateWebDriver(string browserName)
        {
            var driverService = FirefoxDriverService.CreateDefaultService();
            driverService.FirefoxBinaryPath = @"C:\Program Files (x86)\Mozilla Firefox\firefox.exe";
            driverService.HideCommandPromptWindow = true;
            driverService.SuppressInitialDiagnosticInformation = true;
            return new FirefoxDriver(driverService, new FirefoxOptions(), TimeSpan.FromSeconds(60));
        }
    }
}
