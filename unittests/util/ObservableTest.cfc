﻿<cfcomponent hint="tests the Observable implementation" extends="unittests.AbstractTestCase" output="false">

<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="setup" hint="" access="public" returntype="void" output="false">
	<cfscript>
		observable = createObject("component", "coldspring.util.Observable").init();
    </cfscript>
</cffunction>

<cffunction name="addAndUpdateTest" hint="testing adding an observer, and updating" access="public" returntype="void" output="false">
	<cfscript>
		var local = {};

		local.observer1 = createObject("component", "unittests.util.com.Observer").init();
		local.observer2 = createObject("component", "unittests.util.com.Observer").init();

		observable.addObserver(local.observer1);

		local.args = { check1 = 1 };

		observable.update(argumentCollection=local.args);

		assertTrue(structKeyExists(local.observer1, "check1"), "Should be 'check1'");
		assertEquals(1, local.observer1.check1);
		assertFalse(structKeyExists(local.observer2, "check1"), "Should not be 'check1'");

		observable.addObserver(local.observer2);

		local.args = { check2 = 2 };

		observable.update(argumentCollection=local.args);

		assertTrue(structKeyExists(local.observer1, "check2"), "Should be 'check2'");
		assertEquals(2, local.observer1.check2);

		assertTrue(structKeyExists(local.observer2, "check2"), "Should be 'check2'");
		assertEquals(2, local.observer2.check2);
    </cfscript>
</cffunction>

<cffunction name="addAndRemoveTest" hint="testing adding and removing an observer, and updating" access="public" returntype="void" output="false">
	<cfscript>
		var local = {};

		local.observer1 = createObject("component", "unittests.util.com.Observer").init();
		local.observer2 = createObject("component", "unittests.util.com.Observer").init();

		observable.addObserver(local.observer1);
		observable.addObserver(local.observer2);

		observable.removeObserver(local.observer2);

		local.args = { check1 = 1 };

		observable.update(argumentCollection=local.args);

		assertTrue(structKeyExists(local.observer1, "check1"), "Should be 'check1'");
		assertEquals(1, local.observer1.check1);
		assertFalse(structKeyExists(local.observer2, "check1"), "Should not be 'check1'");

		observable.removeObserver(local.observer1);

		local.args = { check2 = 2 };

		observable.update(argumentCollection=local.args);

		assertFalse(structKeyExists(local.observer1, "check2"), "Should not be 'check2'");
		assertFalse(structKeyExists(local.observer1, "check2"), "Should not be 'check2'");
    </cfscript>
</cffunction>

<cffunction name="testReturnValue" hint="test whether it returns the right value" access="public" returntype="void" output="false">
	<cfscript>
		var local = {};

		local.observer1 = createObject("component", "unittests.util.com.Observer").init();
		local.observer2 = createObject("component", "unittests.util.com.Observer").init(returnValue="bar");

		observable.addObserver(local.observer1);
		observable.addObserver(local.observer2);

		local.value = observable.returnString();

		assertEquals("bar", local.value);
	</cfscript>
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->


</cfcomponent>