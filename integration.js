class Script {
  process_incoming_request({ request }) {
    var main_text = request.content.text;
	console.log(request.content);
    if(request.content.info){
        let attFields = [];
      
      	if(request.content.info.fields){
          for (i=0; i<request.content.info.fields.length; i++) {
          	attFields.push(request.content.info.fields[i])
        	}
        }
      	
        var attachment = {
          title:request.content.info.title,
          text:request.content.info.text,
          collapsed: request.content.info.collapsed.IsPresent ? request.content.info.collapsed : null,
          color: '#' + request.content.info.color,
          fields: attFields ? attFields : null
        }
    }
    if(attachment){
      console.log(request.content.info.fields);
      return {
		content:{
          emoji:request.content.emoji,
          alias:request.content.alias,
          text: main_text,
          "attachments": [attachment]
       	}
    	};
    }
    else{
      return {
        content:{
          emoji:request.content.emoji,
          alias:request.content.alias,
          text:main_text
        }
      };
    }
    
    
    return {
       error: {
         success: false,
         message: ':warning:'
       }
     };
  }
}