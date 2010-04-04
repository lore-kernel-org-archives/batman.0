Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 4 Apr 2010 10:58:33 +0800
References: <4BB70C4B.5000909@nord-west.org>
	<201004031841.46758.sven.eckelmann@gmx.de>
	<201004040029.26465.sven.eckelmann@gmx.de>
In-Reply-To: <201004040029.26465.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004041058.33336.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] running batman-adv in a openvz VE
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday 04 April 2010 06:29:24 Sven Eckelmann wrote:
> Also we only use init_net in hard_interface.c when we add a 
> interface - so the actual namespace should not be a problem. But I am a
>  little  bit curious why we only deactivate the interface in  hard_if_event
>  when it gets NETDEV_UNREGISTER. I would think that batman_if->net_dev of
>  that interface isn't valid anymore and we aren't allowed to access it. So
>  removing it should be the right choice.

The idea was to support some buggy (wifi) drivers better. Back in the layer 3 
days I had a driver (not exactly sure which one) that would disappear for a 
second and then come back immediately afterwards. In that case we don't want 
to purge all routing information over and over again.


> I started to write some tests, but then noticed quite fast that (at least
>  in  0.2.1) all variables to store the proc filesystem information are
>  global variables - which will not work.

Yes, this is why I mentioned the multiple mesh support in one of my earlier 
mails. The current stable module (0.2.x) is pretty static and cluttered with 
global variables which I started to clean up.

On the other hand I don't think it is worthwhile to invest much time into the 
proc-fs implementation since it is phasing out. I even thought about 
backporting the sysfs patches to the 0.2.2 branch, so that we can have all 
kernel interface changes while batman-adv resides in the staging tree. Later 
it will be much harder.

Regards,
Marek
