

import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';



/*
class TaskStatusCard extends StatelessWidget {
  const TaskStatusCard({super.key, required this.taskStatusModel});
final TaskStatusModel taskStatusModel ;
  @override
  Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
           color: taskStatusModel.backgroundColor ,
          borderRadius: BorderRadius.circular(20)
       ),
       child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 9 ,vertical: 5),
          child: Text(
             taskStatusModel.statusName ,
             style: robotoMedium.copyWith(color: taskStatusModel.textColor ,fontSize: 12) ,
          ),
       ),
     ) ;
  }
}*/

//***************************




class TaskStatusCard extends StatefulWidget {
  const TaskStatusCard({
    super.key,
    required this.taskStatusModel,
    this.isAssignedToMe,
  });

  final TaskStatusModel taskStatusModel;
  final bool? isAssignedToMe;

  @override
  _TaskStatusCardState createState() => _TaskStatusCardState();
}

class _TaskStatusCardState extends State<TaskStatusCard> {
  late TaskStatusModel selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.taskStatusModel;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isAssignedToMe! ? () => _showDropdownMenu(context) : null, // Désactive l'interaction
      borderRadius: BorderRadius.circular(20),
      mouseCursor: widget.isAssignedToMe! ? SystemMouseCursors.click : SystemMouseCursors.basic, // Curseur adapté
      child: Container(
        decoration: BoxDecoration(
          color: selectedStatus.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isAssignedToMe!) // Affiche l'icône seulement si modifiable
              const Icon(Icons.arrow_drop_down, color: Colors.black),
            if (widget.isAssignedToMe!) const SizedBox(width: 5),
            Text(
              selectedStatus.statusName,
              style: TextStyle(
                color: selectedStatus.textColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) async {
    if (!widget.isAssignedToMe!) return; // Empêche l'ouverture si false

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final newStatus = await showMenu<String>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width, offset.dy + renderBox.size.height + 100,
      ),
      items: List.generate(statusTypes.length, (i) {
        return PopupMenuItem(
          value: statusTypes[i],
          child: Row(
            children: [
              Icon(Icons.circle, color: statusTextColors[i], size: 12),
              const SizedBox(width: 8),
              Text(statusTypes[i], style: TextStyle(color: statusTextColors[i])),
            ],
          ),
        );
      }),
    );

    if (newStatus != null) {
      setState(() {
        int index = statusTypes.indexOf(newStatus);
        selectedStatus = TaskStatusModel(
          statusTextColors[index],
          statusBackgroundColor[index],
          statusTypes[index],
        );
      });
    }
  }
}




/*
class TaskStatusCard extends StatefulWidget {
  const TaskStatusCard({super.key, required this.taskStatusModel});

  final TaskStatusModel taskStatusModel;

  @override
  State<TaskStatusCard> createState() => _TaskStatusCardState();
}

class _TaskStatusCardState extends State<TaskStatusCard> {
  late String selectedStatus;
  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.taskStatusModel.statusName;
    backgroundColor = widget.taskStatusModel.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Change dynamiquement en fonction du statut sélectionné
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          isDense: true, // 🔹 Réduit l'espace vertical
          isExpanded: false, // 🔹 Évite que le bouton prenne toute la largeur
          //iconSize: 18, // 🔹 Réduit la taille de l'icône
          style: const TextStyle(fontSize: 12), // 🔹 Réduit la taille du texte
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          dropdownColor: Colors.white,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedStatus = newValue;
                int index = statusTypes.indexOf(newValue);
                backgroundColor = statusBackgroundColor[index]; // Mise à jour de la couleur de fond
              });
            }
          },
          items: List.generate(statusTypes.length, (i) {
            return DropdownMenuItem(
              value: statusTypes[i],
              child: Text(
                statusTypes[i],
                style: TextStyle(
                  color: statusTextColors[i],
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


*/



 class TaskStatusModel {
  final Color textColor ;
  final Color backgroundColor ;
  final String statusName ;
  TaskStatusModel(this.textColor, this.backgroundColor, this.statusName);
    factory TaskStatusModel.type( String statusName) {
    switch(statusName) {
      case "To-Do" :
        return TaskStatusModel(statusTextColors[0], statusBackgroundColor[0], statusTypes[0]) ;
      case "In progress" :
        return TaskStatusModel(statusTextColors[1], statusBackgroundColor[1], statusTypes[1]) ;
      default :
        return TaskStatusModel(statusTextColors[2], statusBackgroundColor[2], statusTypes[2]) ;
    }

  }
 }

List<Color> statusTextColors = const [Color(0xff0087ff),Color(0xffff7d53) ,Color(0xff5f33e1)] ;
List<Color> statusBackgroundColor = const [Color(0xffe3f2ff) ,Color(0xffffe9e1) ,Color(0xffede8ff)] ;
List<String> statusTypes =["To-do" ,"In progress" ,"Done"] ;


