# BBOrm
Framework for consuming RESTFull API like an ORM

This framework is optimized for a Sails.js Rest API

WARNING: THIS IS A PRE-APLHA VERSION, DO NOT USE IT FOR THE MOMENT

Installation:

Drag the framework into your project

To set an API url:

BBManager.initialize("https://yourapiurl.com")

To activate debug mode:

BBManager.isDebug = true

Now Just subclass the BBObject to get savable objects!

Your object is saved with the Table name = Your class name. If you want to change it just override 
    
public override func getClassName() -> String {
   return "YOURTABLENAME"
}

BE CAREFUL: If you subclass your object, the most Child Class is predominant so take care about SubSubClassing your api objects

If you want some properties to be ignored by the API, name it as myproperty_

Identifiers:

You can change the id property for the object

BBManager.objIdDefault = "id"
   
You can also override it for a specific class

public override func getObjectId() -> String{
	return "myobjectId"
}

IMPORTANT: You have to check if getObjectIdString is a real property of your object and if your objectId type can be cast in String if you change the id property

To provide your own API Routes for custom API :

Default :
getString: String = "/"
getAllString: String = "/"
createString: String = "/create"
updateString: String = "/update"
deleteString: String = "/destroy"

BBAPIRoutes.setRoutes(getString: String,getAllString: String,createString: String,updateString: String,deleteString: String)
