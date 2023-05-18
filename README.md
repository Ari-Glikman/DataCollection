# Data Collection
This is a step-by-step instruction guide for creating a task to collect data about the InterSystems database and globals therein

**Disclaimer: This software is merely for TEST/DEMO purposes. This code is not supported by InterSystems as part of any released product. It is supplied by InterSystems as a demo/test tool for a specific product and version. The user or customer is fully responsible for the maintenance and testing of this software after delivery, and InterSystems shall bear no responsibility nor liabilities for errors or misuse of this code.**

1)	First, import the file “DataCollection.xml” via studio, and make sure there are no errors. If there are it could be a matter of versioning, contact Ari Glikman at ari.glikman@intersystems.com for support on getting a version that’s right for you. Furthermore, ensure that you import the data into the namespace whose internal data you want collected for later inspection.

2)	Once importing is complete you should see the package Sample with several sub-packages as well

      ![image](https://github.com/Ari-Glikman/DataCollection/assets/73805987/526cff85-dcf2-4f3e-b79c-5e6d19c8a499)

If a Sample package is already present on your server, then you should still see the new subpackages along with any other folders that were previously there.

3)	It is now time to run unit testing to make sure everything works correctly. 
a.	Create a folder called Unit Test that can be read by your InterSystems Terminal, for example, since I have a local installation, I will just make a folder in my C drive.
  ![image](https://github.com/Ari-Glikman/DataCollection/assets/73805987/3b2e11d5-6304-4e07-baa7-7ca2460f593c)

b.	Into this folder we will now export the class Sample.DBExpansion.Test.CaptureTest as an xml file.


