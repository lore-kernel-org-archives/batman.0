Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: MK <mailing.m1@kkk-web.de>
Subject: Does batman choose DHCP server by random?
Message-ID: <5e4c619d-bdb1-2fa7-57cc-e5d71ea13f08@kkk-web.de>
Date: Thu, 17 Sep 2020 22:23:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi meshing list.

We are running a batman 2020.2 based mesh network.

Clients connect to one gateway but pull IPv4 addresses from _another_
gateway. This leads to packets flowing between gateways instead of
leaving the mesh on the shortest route possible.

Is this intended behaviour? Is it random? Is there a config option to
alter this packet flow?

gw_mode is set to "server" on all gateways, bandwith announcement is the
same on all gateways (10/10 MBit). So no imbalance here.

Regards,
Martin
