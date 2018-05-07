Return-Path: <me@irrelefant.net>
References: <20180506195559.32602-1-me@irrelefant.net>
 <2722022.Z6qn7ThOV8@bentobox>
From: me <me@irrelefant.net>
Message-ID: <b8f1dd55-d22a-0590-c27a-9c46344af809@irrelefant.net>
Date: Mon, 7 May 2018 10:06:20 +0200
MIME-Version: 1.0
In-Reply-To: <2722022.Z6qn7ThOV8@bentobox>
Content-Type: multipart/mixed; boundary="------------D6D3D714F0B5C9C6BD64A17A"
Content-Language: de-LU
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: mitigate issue when
 empty vlan is received
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>

This is a multi-part message in MIME format.
--------------D6D3D714F0B5C9C6BD64A17A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 05/07/2018 08:32 AM, Sven Eckelmann wrote:
> Can you attach a (small) pcap of actual traffic which show a packet which 
> triggers this behavior?

For sure. See for the originator 5e:25:f7:13:2d:eb and vid=0x8000 in the
attached pcap. I selected the interested packets (one ogm, one full
table request and one full table response).

Kind regards,
Leonardo Mörlein

--------------D6D3D714F0B5C9C6BD64A17A
Content-Type: application/vnd.tcpdump.pcap;
 name="interesting.pcap"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="interesting.pcap"

1MOyoQIABAAAAAAAAAAAAAAABAABAAAAWLrcWh8wCgDuAQAA7gEAAP///////+aPz4PC10MF
AA8vAOY4PQ+iN+YrgMOI5kAgcAEAQgAkBAEAFAGRAAJd5IhAgAAAAHcOeJ0AAAAABgIABAEA
AAACAQAAAA8vAISAH/lmG16oBSOI5kAgcAEAigAkBAEAFAGEAALGJBIpgAAAACvWMPUAAAAA
BgIABAEAAAACAQAAAA8vAM2IXvMK+4ozgAuI5kAgcAEAkwAkBAEAFAEbAAIEPNuKgAAAAHk6
iNEAAAAABgIABAEAAAACAQAAAA8uANhN8A1eJfcTLeuI5kAgcAEAnwAkBAEAFAEtAAIAAAAA
gAAAAHcOeJ0AAAAJBgIABAEAAAACAQAAAA8vAMySBrVu/DZQu/OI5kAgcAEAsAAkBAEAFAES
AAL1nfC+gAAAAGY0hOIAADuQBgIABAEAAAACAQAAAA8uAIg9vzgStmk61huI5kAgcAEAdQAk
BAEAFAEHAAKVgy00gAAAAPvk9qAAAA8QBgIABAEAAAACAQAAAA8uAIg9vzkStmk61huI5kAg
cAEAdQAkBAEAFAEHAAKVgy00gAAAAPvk9qAAAOeQBgIABAEAAAACAQAAAA8vAP/NLeZuEV5D
x8OI5kAgcAEAjgAkBAEAFAE6AAK7MKlvgAAAAIf/zyQAAPFRBgIABAEAAAACAQAAWLrcWm7Q
CgA6AAAAOgAAAIjmQCBwAYaF38fx10MFRA8xAF4l9xMt61Kk1BYyKwAYAAAEAQAUEi0AAgAA
AACAAAAAdw54nQAAAABYutxa9oMLAJoAAACaAAAAiOZAIHABiOZAICABQwVEDzAAUqTUFjIr
XiX3Ey3rAHgAAAQBAHQULQACAAAAAIAA/wB3DnidAAC8jAAAAAAzM/9A+NwAAAAAAAAzMwAA
AAIAAAAAAAAzM/8AAAEAAAAAAACkK7DXF4YAAAAAAAAzMwACEAEAAAAAAAABAF4AAAEAAAAA
AAAzM//XF4YAAAAAAAAzMwAAAAEAAA==
--------------D6D3D714F0B5C9C6BD64A17A--
