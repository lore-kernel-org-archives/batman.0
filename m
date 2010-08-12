Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 12 Aug 2010 12:30:46 +0200
References: <4C63C96F.8070001@web.de>
In-Reply-To: <4C63C96F.8070001@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201008121230.47075.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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

On Thursday 12 August 2010 12:14:07 Tim Glaremin wrote:
> Call Trace:[<80a98a5c>] 0x80a98a5c
> [<800430c0>] 0x800430c0
> [<801a2eb0>] 0x801a2eb0
> [<8004325c>] 0x8004325c
> [<801a6e18>] 0x801a6e18
> [<801a7e40>] 0x801a7e40
> [<801a8aa4>] 0x801a8aa4
> [<80190a00>] 0x80190a00
> [<800a2858>] 0x800a2858
> [<800a6270>] 0x800a6270
> [<800a2f90>] 0x800a2f90
> [<80192028>] 0x80192028
> [<80191330>] 0x80191330
> [<800a3034>] 0x800a3034
> [<80192878>] 0x80192878
> [<80003230>] 0x80003230
> 
> 
> Code: 24c50006  88820003  98820000 <a8a20003> b8a20000  90830004  
> a0a30004  90820005  a0a20005
> Disabling lock debugging due to kernel taint"
> 
> Hope all this info helps you, for me it's only confusing :)

Yeah, we are getting closer !
Could you please enable the kernel debugging information, repeat the last step 
and post the log again. The kernel debugging will replace these numbers by the 
actual function names.
At the bottom of this page you will find an step-by-step guide explaining how 
to activate the kernel debugging: 
http://www.open-mesh.org/wiki/building-batman-adv-with-openwrt

Cheers,
Marek
