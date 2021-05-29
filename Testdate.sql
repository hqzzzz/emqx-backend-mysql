{
  "username": "u_emqx",
  "topic": "Evn/12",
  "timestamp": 1622194958119,
  "qos": 1,
  "publish_received_at": 1622194958119,
  "peerhost": "127.0.0.1",
  "payload": "{\"msg\":\"hello\"}",
  "node": "emqx@127.0.0.1",
  "metadata": {
    "rule_id": "test_rule5dfdfcde"
  },
  "id": "0005C360B23C30A2F4400000167D0000",
  "flags": {
    "sys": true,
    "event": true
  },
  "clientid": "c_emqx"
}


insert into Evn_msg(clientid,msgid, topic, qos, payload, arrivetime) values (${clientid},${id}, ${topic}, ${qos}, ${payload}, FROM_UNIXTIME(${timestamp}/1000))
