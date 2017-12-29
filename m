Return-Path: <rbates@freewave.com>
From: Robert Bates <rbates@freewave.com>
Date: Fri, 29 Dec 2017 17:01:23 +0000
Message-ID: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for unknown
 clients?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

Is it possible to have b.a.t.m.a.n. ARP if packets are received at bat0 for=
 a client which has been removed/deleted due to timeout, and is therefore n=
o longer in the translation tables?

In one customer application of a product of ours (a mesh AP we've licensed =
from another vendor/developer, which is based on openWRT/b.a.t.m.a.n.), we =
are being adversely affected by the 10 minute inactivity timer on transtabl=
e_local.   The clients in this customer's network/application are stationar=
y devices which basically do not speak unless spoken to (e.g. when they are=
 polled for data).  They are periodically polled by a management platform, =
using an upper layer protocol running over TCP.  The problem is that this c=
ustomer's polling cycle time is variable, and occasionally it is taking lon=
ger than 10 minutes between successive polls of a given client/device.  Whe=
n this happens, that client is of course removed from transtable_local, and=
 transtable_global on the other nodes in the mesh.  Meanwhile, the polling/=
management platform has a very long ARP cache life, so it never ARPs (and a=
pparently it is not possible on this platform to have the customer implemen=
t dynamic, rather than static ARP table entries, in which it would ARP upon=
 polling failure).  So once we get into this state, polls to this client de=
vice which has dropped out of the mesh are not possible, and their manageme=
nt platform throws alarms, etc.  To bring it back in service at that point =
requires an ARP, which the customer is manually triggering with a ping, whe=
never one of these "outages" occurs.

We know that the transtable_local inactivity/removal timer value can be ext=
ended, and we will probably do that, but we would also like to know if it i=
s possible to have b.a.t.m.a.n. ARP for the removed client in this case.  W=
e prefer this approach, rather than arbitrarily changing the tt_local timer=
 to some value which may not work well in some other customer's network/app=
lication.  I know that there is a statistically valid underlying assumption=
 with this 10 minute inactivity timer on transtable_local, that clients wil=
l typically be "chatty".  But again, that is not the case in this applicati=
on, which is a very common one in the industry in which we operate, where c=
lients are very often fixed devices which only respond to explicit queries =
or commands.  This is a new product and protocol for us, and this could beg=
 the question of whether or not b.a.t.man.-based meshing is the right solut=
ion in this type of application.  We believe it can be; it would just be he=
lpful if we can configure it to ARP in this type of scenario.

Can you please comment on how this might be possible (config or otherwise)?

Thanks very much,
Robert Bates

IMPORTANT NOTICE:  This communication, including any attachments, is the pr=
operty of FreeWave Technologies, Inc. and may contain proprietary, confiden=
tial, or privileged information. Unauthorized use or disclosure of this com=
munication is strictly prohibited and may be unlawful. Information containe=
d herein may be subject to a Proprietary Information / Non-Disclosure Agree=
ment and shall be maintained in confidence and not disclosed to third parti=
es without the written consent of FreeWave Technologies, Inc. If you have r=
eceived this communication in error, please immediately notify the sender a=
nd destroy all copies of the communication and any attachments.
