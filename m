Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F5336B6.4080603@codigosur.org>
Date: Sun, 04 Mar 2012 06:32:38 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <4F51CA9D.2090404@codigosur.org>
	<201203031932.15663.lindner_marek@yahoo.de>
	<4F52D3B6.5060402@codigosur.org>
	<201203041613.05681.lindner_marek@yahoo.de>
In-Reply-To: <201203041613.05681.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
 + ethernet
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

On 03/04/2012 05:13 AM, Marek Lindner wrote:
> On Sunday, March 04, 2012 10:30:14 Nicolás Echániz wrote:

>> Let me know if you find anything unusual in the setup I sent you.
> 
> The setup looks good as far as I can tell. I backported 2 patches for 2011.4.0 
> that we currently have in the pipeline. They are meant to address temporary 
> routing loops. Somewhat similar to what you are experiencing but I am not 100% 
> sure it will help in your case. Could you please apply these patches to 
> batman-adv and install the patched binary on all nodes ? It is essential that 
> all the nodes run the same version to avoid odd routing behavior.
> 
> Let us know how it goes!

Marek,

these experimental nodes were installed from daily snapshot. and batman
installed with: opkg install kmod-batman-adv. Are these patches already
present in batman-adv 2012.0.0?

If so, we might just re-flash the routers with current trunk; right?

This will take a while because routers are already installed on
roof-tops and the network is in use by some neighbors, but it's still
experimental, so we will do what needs to be donde to get the best
results possible.


