Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Feb 2010 14:18:08 +0800
References: <84e340bd1002232218k6238a13flf790f9e72f2fba9d@mail.gmail.com>
In-Reply-To: <84e340bd1002232218k6238a13flf790f9e72f2fba9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201002241418.09097.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman-adv r1575 on openwrt 8.09.2 no originators
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


Hey,

> On a clean install of openwrt with batman:
> Enable wifi
> Set channel to 1
> set mode to ahdemo
> restart
> 
> Is there something I missed?

what did you restart ?
You may want to configure batman-adv to use the wifi interface. In addition to 
that you should set the cellid if you use ahdemo mode.

Regards,
Marek
