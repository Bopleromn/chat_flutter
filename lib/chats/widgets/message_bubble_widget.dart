part of '../screens/chat_screen.dart';

Map<int, String> monthNumberToMonthName = {
  1: 'Января',
  2: 'Февраля',
  3: 'Марта',
  4: 'Апреля',
  5: 'Мая',
  6: 'Июня',
  7: 'Июля',
  8: 'Августа',
  9: 'Сентября',
  10: 'Октября',
  11: 'Ноября',
  12: 'Декабря',
};

extension on ChatScreenState{
  Widget message_bubble_widget(MessageModel message, context) {
    if (message.userId == 0) {
      return date_bubble_widget(message, context);
    }

    bool isMenuOpened = false;

    return Portal(
        child: PortalTarget(
            visible: isMenuOpened,
            anchor: Aligned(
                follower: Alignment.topRight,
                target: Alignment.topLeft
            ),
            portalFollower: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  isMenuOpened = false;
                });
              },
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Удалить'),
                    Text('Редактировать')
                  ],
                ),
              ),
            ),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMenuOpened = true;
                  });
                  print(isMenuOpened);
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery
                      .sizeOf(context)
                      .width * 0.66),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: message.userId == GetIt.I
                        .get<UserModel>()
                        .id ? Colors.grey : currentTheme.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Text(message.message, style: small_white(),)),
                      SizedBox(width: 1.5.w,),
                      Text(
                          message.sentAt.hour.toString() + ':' + (message.sentAt
                              .toString()
                              .length == 1
                              ? '0${message.sentAt.minute}'
                              : message
                              .sentAt.minute.toString()),
                          style: TextStyle(fontSize: 10, color: light_grey()),
                          textAlign: TextAlign.right
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }

  Widget date_bubble_widget(MessageModel message, context) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery
          .sizeOf(context)
          .width * 0.25),
      height: MediaQuery
          .sizeOf(context)
          .height * 0.03,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: light_grey().withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(message.sentAt.day.toString() + ' ' +
          monthNumberToMonthName[message.sentAt.month]!),
    );
  }
}