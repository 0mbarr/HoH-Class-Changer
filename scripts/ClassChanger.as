namespace ClassChanger
{
	class ClassEntry
	{
		string m_id;
		string m_name;
		string m_desc;
		int m_orePrice;
		array<string> m_flags;

		ClassEntry(UnitPtr unit, SValue& params)
		{
			m_id = GetParamString(unit, params, "class-id");
			m_name = GetParamString(unit, params, "name");
			//m_desc = GetParamString(unit, params, "desc");
			m_orePrice = GetParamInt(unit, params, "ore-price");
			auto arrFlags = GetParamArray(unit, params, "flags");
			for (uint j = 0; j < arrFlags.length(); j++){
				m_flags.insertLast(arrFlags[j].GetString());
				//print(m_flags[j]);
			}
		}
	}

	int GetOrePrice(string classID)
	{
		int oreCost = 0;
		for (uint i = 0; i < g_classes.length(); i++){
			auto currentClass = g_classes[i];
			if (currentClass.m_id == classID)
				oreCost = currentClass.m_orePrice;
		}
		return oreCost;
	}


	array<ClassEntry@> g_classes;
	ClassChangerMenuContent@ g_menu;

	void AddClassFile(SValue@ sval) {
		auto arrClasses = sval.GetArray();
		for (uint i = 0; i < arrClasses.length(); i++)
		{	
			auto svClass = arrClasses[i];
			auto newClass = cast<ClassEntry>(InstantiateClass("ClassChanger::ClassEntry", UnitPtr(), svClass));
			print("loading \"" + newClass.m_name + "\" class");
			if (newClass is null){
				PrintError("The " + newClass.m_name + "class is causing a problem");
				continue;
			}
			g_classes.insertLast(newClass);
		}
	}
}
