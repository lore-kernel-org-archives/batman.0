Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 31 Dec 2017 17:48:42 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20171231164842.GB2985@otheros>
References: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
Subject: Re: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for
 unknown clients?
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

Hi,

If I understood correctly then the ARP cache life on the
polling/management platform is larger than 10min. Would it
be an option for you to lower that one to some value below the
10min. translation table timeout? (the default for the
ARP/neighbor in Linux is a random value between 30-90 seconds
if I remember correctly)

Would that solve your issue?

Regards, Linus


On Fri, Dec 29, 2017 at 05:01:23PM +0000, Robert Bates wrote:
> Hello,
>=20
> Is it possible to have b.a.t.m.a.n. ARP if packets are received at bat0 f=
or a client which has been removed/deleted due to timeout, and is therefore=
 no longer in the translation tables?
>=20
> In one customer application of a product of ours (a mesh AP we've license=
d from another vendor/developer, which is based on openWRT/b.a.t.m.a.n.), w=
e are being adversely affected by the 10 minute inactivity timer on transta=
ble_local.   The clients in this customer's network/application are station=
ary devices which basically do not speak unless spoken to (e.g. when they a=
re polled for data).  They are periodically polled by a management platform=
, using an upper layer protocol running over TCP.  The problem is that this=
 customer's polling cycle time is variable, and occasionally it is taking l=
onger than 10 minutes between successive polls of a given client/device.  W=
hen this happens, that client is of course removed from transtable_local, a=
nd transtable_global on the other nodes in the mesh.  Meanwhile, the pollin=
g/management platform has a very long ARP cache life, so it never ARPs (and=
 apparently it is not possible on this platform to have the customer implem=
ent dynamic, rather than static ARP table entries, in which it would ARP up=
on polling failure).  So once we get into this state, polls to this client =
device which has dropped out of the mesh are not possible, and their manage=
ment platform throws alarms, etc.  To bring it back in service at that poin=
t requires an ARP, which the customer is manually triggering with a ping, w=
henever one of these "outages" occurs.
>=20
> We know that the transtable_local inactivity/removal timer value can be e=
xtended, and we will probably do that, but we would also like to know if it=
 is possible to have b.a.t.m.a.n. ARP for the removed client in this case. =
 We prefer this approach, rather than arbitrarily changing the tt_local tim=
er to some value which may not work well in some other customer's network/a=
pplication.  I know that there is a statistically valid underlying assumpti=
on with this 10 minute inactivity timer on transtable_local, that clients w=
ill typically be "chatty".  But again, that is not the case in this applica=
tion, which is a very common one in the industry in which we operate, where=
 clients are very often fixed devices which only respond to explicit querie=
s or commands.  This is a new product and protocol for us, and this could b=
eg the question of whether or not b.a.t.man.-based meshing is the right sol=
ution in this type of application.  We believe it can be; it would just be =
helpful if we can configure it to ARP in this type of scenario.
>=20
> Can you please comment on how this might be possible (config or otherwise=
)?
>=20
> Thanks very much,
> Robert Bates
>=20
> IMPORTANT NOTICE:  This communication, including any attachments, is the =
property of FreeWave Technologies, Inc. and may contain proprietary, confid=
ential, or privileged information. Unauthorized use or disclosure of this c=
ommunication is strictly prohibited and may be unlawful. Information contai=
ned herein may be subject to a Proprietary Information / Non-Disclosure Agr=
eement and shall be maintained in confidence and not disclosed to third par=
ties without the written consent of FreeWave Technologies, Inc. If you have=
 received this communication in error, please immediately notify the sender=
 and destroy all copies of the communication and any attachments.
