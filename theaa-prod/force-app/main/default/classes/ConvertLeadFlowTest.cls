@isTest
public class ConvertLeadFlowTest {

    @testSetup
    static void setUp() {
        List<Lead> createLeads = new List<Lead>();
        
        for(Integer i = 0; i < 10; i++){
            createLeads.add(new Lead (LastName = 'LastName' + i, Company = 'Company' + i, Email = 'test'+i+'@test.com'));
        }
        insert createLeads;
        
    }
    
    @isTest static void convertLeadProcessTest(){
        
        List<Lead> leadList = [SELECT Id, Name, Email FROM Lead];
        System.assertEquals(10, leadList.size(), 'Expected 10 leads!');
        
        Test.startTest();
        	ConvertLeadFlow.convertLeadProcess(leadList);
        Test.stopTest();
        
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity];
        System.assertEquals(10, oppList.size(), 'Expected 10 Opportunities!');
        
        List<Lead> leadListConverted = [SELECT Id, Name FROM Lead WHERE isConverted = :True];
        System.assertEquals(10, leadListConverted.size(), 'Expected 10 Opportunities!');
        
    }

}