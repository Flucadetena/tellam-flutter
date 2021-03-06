import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/agent.dart';
import 'package:tellam/src/view_models/tellam_conversation_view_model.dart';
import 'package:tellam/src/widgets/oval_image.dart';

class CompanyAgents extends StatefulWidget {
  const CompanyAgents({
    Key key,
    this.tellamConversationViewModel,
  }) : super(key: key);

  final TellamConversationViewModel tellamConversationViewModel;

  @override
  _CompanyAgentsState createState() => _CompanyAgentsState();
}

class _CompanyAgentsState extends State<CompanyAgents> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Agent>>(
      stream: widget.tellamConversationViewModel.agents,
      builder: (context, snapshot) {
        if (!snapshot.hasData && !snapshot.hasError) {
          return SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            height: 60,
            width: 60,
          );
        }

        final agents = snapshot.data;
        double agentHeaderLeftPositioned = -40;

        return Container(
          height: 50,
          child: Stack(
            children: agents.map(
              (agent) {
                agentHeaderLeftPositioned += 40;
                return Positioned(
                  left: agentHeaderLeftPositioned,
                  child: OvalImage(
                    height: 50,
                    weight: 50,
                    url: agent.photo,
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
