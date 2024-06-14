import 'package:arosaje/models/plante_resume.dart';
import 'package:flutter/material.dart';
import 'plant_view.dart';

class MyPlantsDiv extends StatefulWidget {
  PlanteResume planteResume;
  Function() refresh;

  MyPlantsDiv(this.planteResume, this.refresh, {super.key});

  @override
  _MyPlantsDivState createState() => _MyPlantsDivState();
}

class _MyPlantsDivState extends State<MyPlantsDiv> {
  bool isHovered = false;
  bool deleteHovered = false;
  bool editHovered = false;
  bool shareHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlantPage(widget.planteResume.idPlantePerso)),
          );
          widget.refresh();
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isHovered ? Color(0xFFA2C48B).withOpacity(0.5) : Color(0xFFA2C48B).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widget.planteResume.image,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.planteResume.nomPlante,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        _buildTextWithIcon(Icons.person, 'Propriétaire : ${widget.planteResume.username}'),
                        _buildTextWithIcon(Icons.location_on, 'Lieu : ${widget.planteResume.adresseApproximative}'),
                        _buildTextWithIcon(Icons.event, 'Date du semis : ${widget.planteResume.dateCreation.toString()}'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextWithIcon(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                overflow: TextOverflow.clip
              ),
            ),
          )

        ],
      ),
    );
  }
}
