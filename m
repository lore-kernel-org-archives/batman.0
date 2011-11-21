Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 21 Nov 2011 15:02:41 +0800
References: <4EC967CC.1040804@gmail.com> <20111120211558.GA11262@autistici.org>
	<4EC9766D.9000302@gmail.com>
In-Reply-To: <4EC9766D.9000302@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201111211502.41446.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Connecting non-batman nodes to a mesh network
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


Hi,

> The devices have either RTL8188SU or RTL8188CUS chipsets from Realtek.
> Drivers can be found here -
> http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=48&PFi
> d=48&Level=5&Conn=4&DownTypeID=3&GetDown=false&Downloads=true#RTL8188SU
> <http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=48&P
> Fid=48&Level=5&Conn=4&DownTypeID=3&GetDown=false&Downloads=true#RTL8188SU>
> 
> May be they are mac80211 compatible, but I am not sure. Can you give me
> an example of creating a virtual interface so I can try?

the keywords you want to search for are: multi VAP, multi SSID & mac80211 iw
A few links that came out of that search:
http://linuxwireless.org/en/users/Drivers
http://linuxwireless.org/en/users/Documentation/iw

I somehow doubt that the Realtek chip supports the mac80211 infrastructure. 
You might want to switch to the mac80211 driver for your chip. Not all chips 
support multi VAPs though.

Note: This mailing list is about batman and not so much about how to setup / 
configure your wifi driver or what features it supports.

I extended our FAQ with your question. Thanks for bringing it up.

Cheers,
Marek
