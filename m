Return-Path: <cmsv@wirelesspt.net>
Message-ID: <511E55B5.60900@wirelesspt.net>
Date: Fri, 15 Feb 2013 10:35:17 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Classes and purposed classes (problem to solve)
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Scenario:
I have recently moved 13 nodes previously using wds  to batman-adv.
One problem that i am encountering is the gateway selection and its
actually defectiveness.
This problem has be seen when the client nodes are set on class 20.

The node clients in fact select the gateways that advertise better link
quality usually above 200 but at the same time some clients  end up
connecting to a gateway that is either too slow or unusable either due
to routing or other factors such as distance and even clear visibility.
In one case the node connects to something that defies logic.

I thought about ways to work around this and came up with an idea that
may help which means the creation of 2 new classes.

- Preferred gateway fall-back

- Preferred fixed gateway

For  Preferred gateway fall-back:

consider the gateway's advertised quality towards the gateway and stick
with the selection until the gateway disappears returning to it soon as
it returns regardless of any other data.

- Preferred fixed gateway
Manual gateway selection by the node owner or admin. (wds type)

If these classes cannot be created; maybe a plugin of some sort could
be. could be called "gordon".


 I understand that this idea may sound useless the same way blocking
originators may be for someone but in some scenarios just like blocking
originators it look to me very valid.
My current problem is that the link quality seems to go up and down like
 a roller coaster in a specific order which causes the clients to switch
constantly sometimes many times per hour.
While this does not seem to be an issue for most client nodes; for 2 of
them it means no internet access at all.

The solution for now seems to be having these 2 nodes forced to use 1
specific gateway.


I am quite open to any ideas that may help resolve this issue that has
been casing some "uninformed people" to become headaches.





-- 






Redes wireless
http://wirelesspt.net
