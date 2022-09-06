Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Tue, 6 Sep 2022 09:56:15 -0600
Message-ID: 
 <CAA_JP8Ucxq8=RZhxUfKtEDGs43wQTCd8UY_JJXGC=CWrM8Uofg@mail.gmail.com>
Subject: zero hop penalty interface?
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all.  I'm struggling to find an answer to this specific question
about path selection.

I'm looking at building a prototype mesh out of the banana pi BPI-R3.
That's a dual band wifi 6/6e router that runs open-wrt.  1x 2.4Ghz and
1x5-6Ghz.

I would build this as a quasi-dual radio mesh.  ie, I want to favor
the 5-6Ghz radio and add a large hop penalty to the 2.4Ghz so that
it's only used for backup.  The 2.4Ghz is a fraction the speed of the
5-6Ghz.

What I'm considering is that as I saturate the 'single radio mesh'
that the 5-6Ghz radios is essentially making since 2.4Ghz is purposely
high-cost, I may want to add a second unit starting from the main
uplink out as a secondary mesh, then linking both units together via
2.5-5GbE ports on the device.

The question is, can I make the hop penalty zero so the mesh treats
this pair of routers basically as one?  for instance data comes into
node10a's 5Ghz radio, I'd like that to try to go across the 'zero
cost' ethernet and exit via node10b's 5Ghz radio to make this
effectively a dual radio mesh.  Ultimately the same would be true of
the 2.4Ghz but again, that's ideally for backup meshing as it should
look like an expensive hop.
