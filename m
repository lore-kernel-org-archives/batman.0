Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Jun 2009 21:10:40 +0800
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
In-Reply-To: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906182111.03769.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Friday 12 June 2009 01:40:11 Jacob Marble wrote:
> So far, I have an adhoc network on ath0, and I have installed
> batmand-adv, battool, and kmod-batman-advanced.  Do I need
> badmand-adv?  Is this the old userspace batman-adv implementation?

Yes, batman-adv is the old user space implementation. Please use the latest 
OpenWRT package which does not contain this daemon anymore. Remove the daemon 
first and check whether it works for you then.

Regards,
Marek

