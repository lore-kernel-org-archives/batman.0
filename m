Return-Path: <patrick.bosch@uantwerpen.be>
MIME-Version: 1.0
Date: Fri, 20 Nov 2015 15:42:36 +0100
Message-ID: <CANQCUf=qAPBc7qwTgYJ3KuPZVMm9crsoYLTXKePiCx1bQJkisw@mail.gmail.com>
From: Patrick Bosch <patrick.bosch@uantwerpen.be>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Integrity checks for packets, who does it?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi everyone

I have a little uncertainty regarding integrity checks in batman
advanced. I was wondering which encapsulation does it.

The situation:
- Ping to a batman node
- Normal ping, no batman ping (nodes have an IP)
- WPA2 active

ICMP should be encapsulated by IP, which is encapsulated by the Wi-Fi
mac header. Now I know that batman advanced inserts it's own header.
The question is, where exactly? Does it encapsulate the Wi-Fi mac and
takes over the integrity check or not? Also, how does it behave in the
case of enabled encryption? WPA2 has it's own integrity check.

The reason I ask, is that in Wireshark, it appears as ICMP when I
sniff the traffic without encryption enabled.

It would be great, if someone could shed light in this affair! Thank
you in advance!

Kind regards
Patrick

-- 
Patrick Bosch, PhD Student
University of Antwerp - iMinds
Dept. Mathematics and Computer Science
MOSAIC research group
Middelheimlaan 1 - Room M.G.215
2020 Antwerpen - Belgium
Email: patrick.bosch@uantwerpen.be
Phone: +3232653858
