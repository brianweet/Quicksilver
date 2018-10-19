using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Remote;
using Xunit;

namespace EPiServer.Reference.Commerce.Site.SeleniumTests
{
    public static class SimpleTests
    {
        [Theory]
        [InlineData("Chrome")]
        public static void CanReachStartpage(string browserName)
        {
            var url = "http://quicksilver-appveyor-dns.westeurope.azurecontainer.io";
            using (var driver = CreateWebDriver(browserName))
            {
                driver.Navigate().GoToUrl(url);
                Assert.StartsWith("Start", driver.Title);
            }
        }

        [Theory]
        [InlineData("Chrome")]
        public static void CanFindHeading(string browserName)
        {
            var url = "http://quicksilver-appveyor-dns.westeurope.azurecontainer.io";
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
            return new RemoteWebDriver(new ChromeOptions());
        }
    }
}
