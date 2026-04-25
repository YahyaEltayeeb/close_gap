// import 'package:close_gap/features/experience/presentation/widgets/meta_chip.dart';
// import 'package:flutter/material.dart';

// class BackendNoteCard extends StatelessWidget {
//   const BackendNoteCard({super.key, required this.itemCount});

//   final int itemCount;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(22),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x12000000),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Backend-aligned UI',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Fields match POST /experience/: company_name, title, start_date, end_date, description, skills.',
//             style: TextStyle(color: Colors.grey.shade700, height: 1.45),
//           ),
//           const SizedBox(height: 12),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: [
//               MetaChip(label: 'GET list: $itemCount item(s)'),
//               const MetaChip(label: 'PUT supported'),
//               const MetaChip(label: 'DELETE supported'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
