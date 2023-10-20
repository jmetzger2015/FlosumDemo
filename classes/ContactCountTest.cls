@isTest
public with sharing class ContactCountTest {

    @TestSetup
    static void makeData(){
        String uniqueId = DateTime.now().millisecond().format();

        Account acct = new Account(
          Name='TEST-Account-1',
          BillingCountry = 'US',  
          BillingStreet = '1600 Alvarado Street',
          BillingCity = 'San Leandro',
          BillingState = 'CA',
          BillingPostalCode = '94577',
          Industry = 'Technology',
          Phone = '415-555-5555');
        Database.SaveResult acctSR = Database.insert(acct);
        System.assert(acctSR.isSuccess());

        Account testAcct2 = new Account(
          Name='TEST-Account-2',
          BillingCountry = 'US',  
          BillingStreet = '1001 Locust St',
          BillingCity = 'Kansas City',
          BillingState = 'MO',
          BillingPostalCode = '64106',
          Industry = 'Construction',
          Phone = '415-555-5556');
        Database.SaveResult testAcct2SR = Database.insert(testAcct2);
        System.assert(testAcct2SR.isSuccess());


        Contact con = new Contact(
          FirstName = 'FN-' + uniqueId,
          LastName = 'LN-' + uniqueId + ' Contact ', 
          AccountId = acct.Id,
          MailingCountry = acct.BillingCountry,
          MailingStreet = acct.BillingStreet,
          MailingCity = acct.BillingCity,
          MailingState = acct.BillingState,
          MailingPostalCode = acct.BillingPostalCode,
          Phone = '415-555-' + uniqueId.left(4),
          Email = String.format('testemail-{0}@docusign.com', new List<Object>{uniqueId}));

      Database.SaveResult conSR = Database.insert(con);
      System.assert(conSR.isSuccess());

    }
    @isTest
    public static void contactCountInsertPositiveTest(){
       String uniqueId = DateTime.now().millisecond().format();

        Account acct = [SELECT Id, BillingCountry, BillingStreet, BillingState, BillingCity, BillingPostalCode  FROM Account WHERE Name = 'TEST-Account-2' LIMIT 1];

        Contact con = new Contact(
            FirstName = 'FN-' + uniqueId,
            LastName = 'LN-' + uniqueId + ' Contact ', 
            AccountId = acct.Id,
            MailingCountry = acct.BillingCountry,
            MailingStreet = acct.BillingStreet,
            MailingCity = acct.BillingCity,
            MailingState = acct.BillingState,
            MailingPostalCode = acct.BillingPostalCode,
            Phone = '415-555-' + uniqueId.left(4),
            Email = String.format('testemail-{0}@docusign.com', new List<Object>{uniqueId}));

        Database.SaveResult conSR = Database.insert(con);
        System.assert(conSR.isSuccess());

        Account updatedAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acct.Id];
        System.assertEquals(1, updatedAccount.Number_of_Contacts__c, 'Error number of contacts != 1. Found: ' + updatedAccount.Number_of_Contacts__c);
    }
    
    @isTest
    public static void contactCountUpdatePositiveTest(){
        String uniqueId = DateTime.now().millisecond().format();

        Account acct = [SELECT Id, Number_of_Contacts__c FROM Account LIMIT 1];
        acct.Number_of_Contacts__c = 0;
        Database.SaveResult acctUpdSR = Database.update(acct);
        System.assert(acctUpdSR.isSuccess());

        Account testAcct = [SELECT Id, Number_of_Contacts__c, BillingCountry, BillingStreet, BillingState, BillingCity, BillingPostalCode  FROM Account WHERE Name = 'TEST-Account-2' LIMIT 1];

        System.assertEquals(null, testAcct.Number_of_Contacts__c);

        Contact con = new Contact(
          FirstName = 'TestContact',
          LastName = 'LN-' + uniqueId + ' Contact ', 
          MailingCountry = testAcct.BillingCountry,
          MailingStreet = testAcct.BillingStreet,
          MailingCity = testAcct.BillingCity,
          MailingState = testAcct.BillingState,
          MailingPostalCode = testAcct.BillingPostalCode,
          Phone = '415-555-' + uniqueId.left(4),
          Email = String.format('testemail-{0}@docusign.com', new List<Object>{uniqueId}));

        Database.SaveResult conSR = Database.insert(con);
        System.assert(conSR.isSuccess());
        Contact testContact = [SELECT Id, AccountId FROM Contact where Id = :conSR.getId()];
        testContact.AccountId = testAcct.Id;
        Database.SaveResult testContactSR = Database.update(testContact);
        System.assert(testContactSR.isSuccess());
        Account testAcctUpdated = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :testAcct.Id];
        System.assertEquals(2, testAcctUpdated.Number_of_Contacts__c);
    }
           @isTest
    public static void contactCountDeletePositiveTest(){
        Contact con = [SELECT Id, AccountId, FirstName  FROM Contact LIMIT 1];
        Database.DeleteResult deleteSR = Database.delete(con);
        System.assert(deleteSR.isSuccess());

  
    }
    
  
}