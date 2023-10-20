<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Expire_Date_is_updated</fullName>
        <field>Expire_Date__c</field>
        <formula>Start_Date__c</formula>
        <name>Expire Date is updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Iphone Version</fullName>
        <actions>
            <name>Expire_Date_is_updated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>iPhone__c.Iphone_Version__c</field>
            <operation>equals</operation>
            <value>5S,6</value>
        </criteriaItems>
        <criteriaItems>
            <field>iPhone__c.Does_it_charge__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>iPhone__c.CreatedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
