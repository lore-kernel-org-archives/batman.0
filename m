Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 18 Oct 2011 21:22:05 +0200
References: <22002081.QEpvgSbQlm@sven-desktop.home.narfation.org>
In-Reply-To: <22002081.QEpvgSbQlm@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201110182122.06484.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Compile error on openwrt with new patch
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
Cc: Jo-Philipp Wich <xm@subsignal.org>


Filippo,

could you please always send your mails to the mailing list ? If you stop 
sending to the list we don't know what is gloing on.


> and in svn://svn.openwrt.org/openwrt/branches/packages_10.03.1 there
> is batman-adv 2011.2.0 package.
> 
> It is a openwrt problem? my feeds.conf.default is the original openwrt
> conf.

Yes, it seems that Jow from the OpenWrt team has copied the patches intended 
for batman-adv 2011.3.0 to 2011.2.0.

@Jow: Could you please revert the comitts 28473 and 28477.

Thanks,
Marek
