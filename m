Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Scooter Willis <willishf@gmail.com>
Date: Fri, 29 Jan 2021 06:43:25 +0500
Message-ID: <CAMjFWEOpvMmedQw7sB-G1f9pMMo6ymhZemVy07Y0UeUN+EPU1w@mail.gmail.com>
Subject: Mobile Vehicle Mesh Network
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Doing some research to see what options are available for a hybrid
mobile-mesh network.

The application would be a large warehouse with fixed nodes overhead
connected via ethernet/POE.

On the warehouse floor would be some number of robots that as they
travel would go in and out of range for an overhead access point. On
the robot would be 2-5 computer devices that would connect to the
access point on the robot via ethernet.

Would have one gateway for the entire warehouse in that all internet
traffic would be local.

If the robot which is moving has the equivalent access point mesh node
as the static access points overhead would want very quick handoff to
the next access point where signal strength of the wifi would be the
reason to pick a specific access point. The 2-5 computers on the robot
should see the minimal impact when the access point switches to
another overhead access point. For the 2-5 computers on the device
want to minimize cost/wifi noise and the reason to have them plugged
into a local switch.

For batman-adv wanted to see if you could provide any guidance that it
would work in this configuration where some number of mesh nodes are
dynamic and are moving. It may also be optimal for a robot not in
range of overhead wireless to connect to other moving robots that are
mesh nodes.
