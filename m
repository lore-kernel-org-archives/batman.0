Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F65815D.4090605@codigosur.org>
Date: Sun, 18 Mar 2012 03:31:57 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <4F51CA9D.2090404@codigosur.org>
	<201203041613.05681.lindner_marek@yahoo.de>
	<4F5336B6.4080603@codigosur.org>
	<201203041852.17799.lindner_marek@yahoo.de>
In-Reply-To: <201203041852.17799.lindner_marek@yahoo.de>
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

On 03/04/2012 07:52 AM, Marek Lindner wrote:
> On Sunday, March 04, 2012 17:32:38 Nicolás Echániz wrote:
>> these experimental nodes were installed from daily snapshot. and batman
>> installed with: opkg install kmod-batman-adv. Are these patches already
>> present in batman-adv 2012.0.0?
>>
>> If so, we might just re-flash the routers with current trunk; right?
> 
> No, these patches are not part of any release yet. You need to compile your 
> own batman-adv with the patches applied. We have a document explaining how you 
> should proceed: http://www.open-mesh.org/wiki/batman-adv/Building-with-openwrt
> 
> 
>> This will take a while because routers are already installed on
>> roof-tops and the network is in use by some neighbors, but it's still
>> experimental, so we will do what needs to be donde to get the best
>> results possible.
> 
> There is no need to reflash all the routers. You can simply build a patched 
> batman-adv package and install it on top of your current image. The important 
> part is that you compile the batman-adv kernel module for exactly the same 
> kernel you are running.

Hi Marek,

I've finally had the time to look into this again.

The routers have been updated to current OpenWRT trunk and batman-adv
version has changed, would it be too much inconvenience for you to send
me your patches for 2012.0.0?

thanks in advance.

NicoEchániz
