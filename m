Return-Path: <jorgepower99@gmail.com>
MIME-Version: 1.0
Sender: jorgepower99@gmail.com
From: jorge power <jorge@alumni.ufl.edu>
Date: Thu, 28 Jul 2016 09:04:24 -0400
Message-ID: <CAHuRCtSLOUaV1NM6e1Gda74tMoiLKB8E3zyezoxT=8c5pV=KQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] broadcast / flooding
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

I am using batman (2012) for a wireless network where we have a
polling based or star type network /mac topology.  Similar to wifi PCF
but proprietary instead of DCF.

I have noticed that if i have just 2 nodes and one node sends
broadcast data (say video 192.168.1.255) that the other batman node
will turn around and also re-transmit the same data back out.  So
basically i see twice the data on the over the air network which the
originating batman node drops since it originated from him.

Two Questions:
1) given that there are only two nodes , does BATMAN adv have a way to
realize there aren't other nodes wanting to receive the broadcast and
since the source of the broadcast is the only other batman node it
shouldn't transmit it again?

2) For cases of where batman is used in a more structured network
instead of a true mesh/adhoc topology, are there parameters that could
be used to limit re-broadcasting data received via wlan interface?

-- 
Thanks
Jorge
