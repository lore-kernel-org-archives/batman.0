Return-Path: <nino.sutter@bfh.ch>
From: Sutter Nino <nino.sutter@bfh.ch>
Date: Wed, 17 Feb 2016 07:59:37 +0100
Message-ID: <370FBFE49C48C642A1C49A056DBFC0702B70DECEB9@BFHMAIL04.bfh.ch>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] How is the metric calculated and interpreted?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>

Hello there

I have some basic Issues which I was not able to solve with the Wiki.

How is the metric (?/255) calculated?

Concerning the output of  "batctl o" below, how can I interpret the followi=
ng?=20
-What is the meaning when the originator is the same as the next hop (Line =
1)?
-Is that correct that the originator car 29 will send all packets to car20 =
directly without a node in-between (Line 2)?
-How can the potential nexthops be interpreted?

[B.A.T.M.A.N. adv 2015.1, MainIF/MAC: adhoc0/c4:93:00:02:d1:4f (bat0 BATMAN=
_IV)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Poten=
tial nexthops ...
car23                     0.300s (255)                        car23 [ wlan0=
]: car35 ( 0) car24 ( 0) car31 (103) car21 (183) car36 ( 68) car20 (178) ca=
r23 (255)=20
car29                     0.864s (175)                        car20 [ wlan0=
]: car23 ( 0) car36 ( 0) car31 ( 0) car35 ( 0) car21 ( 0) car24 ( 0) car20 =
(175) car29 ( 0)

Thank you for your answers

Regards=20
Nino
