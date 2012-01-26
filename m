Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 27 Jan 2012 03:36:09 +0800
References: <110B6C33195F5F4790292BDD9E7DED401AB93E918F@VA3DIAXVS371.RED001.local>
In-Reply-To: <110B6C33195F5F4790292BDD9E7DED401AB93E918F@VA3DIAXVS371.RED001.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201270336.09947.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv
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

On Monday, January 23, 2012 22:55:09 Bouterse, Robert wrote:
> My attempts to use the hop_penalty failed, since I do not have control over
> the RF environment. So, I am resurrecting an old thread to find out if
> this is possible :
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-July/005058.html
> 
> The state of the thread seems to have ended with the idea of wrapping a
> wlan0 interface in a bridge, and then adding the bridge to a batman-adv
> network. This worked (apparently) with batman-adv over ethernet, but will
> not work over 802.11 because the kernel specifically prevents the bridge
> from being created,
> http://lists.shmoo.com/pipermail/hostap/2010-January/020959.html
> 
> There is some mention that batman-adv has ebtables support.
> 
>  How can I get at that, to do what the people in the thread, were trying to
> accomplish?

It does not exist. The ebtables support has been removed shortly after its 
introduction because it came with some disadvantages. Unless you invest some 
time to implement something you won't have a solution.

Regards,
Marek
