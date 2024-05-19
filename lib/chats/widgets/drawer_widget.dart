part of '../screens/chats_screen.dart';

extension on ChatsScreenState{
  // ignore: non_constant_identifier_names
  Widget drawer_widget(){
    final nameController = TextEditingController();
    return Drawer(
      backgroundColor: currentTheme.colorScheme.background,
      child: Padding(
        padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 10.h),
        child: Column(
          children: [
            SizedBox(
              height: 135,
              width: 135,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: user.photo.length == 0 ? const NetworkImage('https://qph.cf2.quoracdn.net/main-qimg-6d72b77c81c9841bd98fc806d702e859-lq') :
                                                              NetworkImage('http://${globals.ip}/images?name=${user.photo}'),
                  ),
                  Positioned(
                      bottom: 0,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () async{
                          String path = await picImage();
                          try{
                          if(path.length != 0){
                            path = path.replaceAll('/', '\\');
                            String name = path.substring(path.lastIndexOf('\\') + 1);

                            if(await saveImage(path, name)){
                              setState(() {
                                user.photo = name;
                              });
                            }
                          }
                          }catch (e){
                            print(e);
                            print(path);
                          }
                        

                        },
                        elevation: 2.0,
                        fillColor: currentTheme.primaryColor,
                        child: const Icon(Icons.camera_alt_outlined, color: Colors.white,),
                        padding: const EdgeInsets.all(10),
                        shape: const CircleBorder(),
                      )),
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            animatedWidget(
                callback: (){
                  openFieldDialog(
                      title: 'Имя',
                      value:  user.name,
                      controller: nameController,
                      callback: (){
                        if(nameController.text.length > 1 && nameController.text.startsWith('@')){
                          user.name = nameController.text;
                        }

                        setState(() {
                          user.name;
                        });
                      },
                      readOnly: false
                    );
                },
                child: field(
                    fieldName: 'Имя',
                    fieldValue: user.name,
                    icon: CupertinoIcons.profile_circled,
                )
            ),
            animatedWidget(
                callback: (){},
                child: field(
                    fieldName: 'Почта',
                    fieldValue: user.email,
                    icon: CupertinoIcons.mail,
                )
            ),
            animatedWidget(
                callback: (){},
                child: Container(
                  height: 7.h,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.moon, size: 20.sp, color: currentTheme.iconTheme.color),
                      SizedBox(width: 1.w,),
                      Text('Ночная тема', style: small_black(),),
                      Spacer(),
                      Switch(
                        value: _isDarkTheme,
                        onChanged: (newBool){
                          _isDarkTheme = newBool;
                          currentTheme = _isDarkTheme ? darkTheme : lightTheme;

                          setState(() {
                            _isDarkTheme;
                            currentTheme;
                          });
                        },
                        activeTrackColor: currentTheme.primaryColor,
                        inactiveThumbColor: currentTheme.colorScheme.background,
                        inactiveTrackColor: currentTheme.secondaryHeaderColor.withOpacity(0.2),
                      )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget animatedWidget({required Function() callback, required Widget child}){
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: callback,
          child: child
        )
    );//
  }

  Widget field({required String fieldName, required String fieldValue, required IconData icon}){
    return Container(
      height: 7.h,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
        Icon(icon, size: 20.sp, color: currentTheme.iconTheme.color,),
        SizedBox(width: 1.w,),
        Text(fieldName, style: small_black(),),
        Spacer(),
        Text(fieldValue, style: small_primary(),),
        ],
      ),
    );
  }

  Future openFieldDialog({required String title, required String value,
                          required TextEditingController controller, required Function() callback,
                          required bool readOnly}) {
    controller.text = value;

    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor: currentTheme.colorScheme.background,
              title: Text(title, style: medium_black(),),
              content: TextField(
                controller: controller,
                readOnly: readOnly,
                style: small_black(),
                decoration: field_regular_decoration('Введите ' + title),
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Отменить',)
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: (){
                          callback();
                          Navigator.of(context).pop();
                        },
                        child: Text('Сохранить',)
                    )
                  ],
                )
              ],
            )
     );
  }
}