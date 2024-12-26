import 'package:signalr_core/src/hub_protocol.dart';
import 'package:signalr_core/src/json_hub_protocol.dart';
import 'package:signalr_core/src/text_message_format.dart';
import 'package:test/test.dart';

void main() {
  test('can read ping message', () {
    final payload = '{"type":6}${TextMessageFormat.recordSeparator}';
    final messages = JsonHubProtocol()
        .parseMessages(payload, (level, message) => print(message));
    expect(messages, equals([PingMessage()]));
  });

  test('can read completion message', () {
    final payload = '{"type":3,"invocationId":"0","result":{"data":"123"}}'
        '${TextMessageFormat.recordSeparator}';
    final messages = JsonHubProtocol()
        .parseMessages(payload, (level, message) => print(message));
    expect(
        messages,
        equals([
          CompletionMessage(invocationId: '0', result: {'data': '123'})
        ]));
  });
}
