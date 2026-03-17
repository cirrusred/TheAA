public class ConvertLeadFlow {
    
    @InvocableMethod(Label='Convert Lead and Create Opportunity')
    public static void convertLeadProcess (List<Lead> leadIdtoConvert){

		List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>(); 
     
        for(Lead l : leadIdtoConvert){
            Database.LeadConvert lc = new Database.LeadConvert();
            
        	lc.setLeadId(l.Id);
            lc.setConvertedStatus('Qualified');
            lc.setOpportunityName(l.Name);
            
            leadConverts.add(lc);
        }
        
        List<Database.LeadConvertResult> lcrList = Database.convertLead(leadConverts);
        List<Id> oppIdList = new List<Id>();
        
        for (Integer i = 0; i < lcrList.size(); i++) {
            if (!lcrList[i].isSuccess()) {
                System.debug('Convertion error: ' + lcrList[i].getErrors() + ' on lead : ' + lcrList[i]);
            }
            else{
                oppIdList.add(lcrList[i].getOpportunityId());
            }
        }

        List<Opportunity> opportunitiesList = [SELECT Id, StageName FROM Opportunity Where Id IN :oppIdList];
        
        for(Opportunity opp : opportunitiesList){
            opp.StageName = 'Qualification';
        }
        
        update opportunitiesList;
    }
}