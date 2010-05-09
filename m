Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 May 2010 15:20:27 +0800
References: <201005091117.05627.lindner_marek@yahoo.de>
	<20100509070835.GA20977@lunn.ch>
In-Reply-To: <20100509070835.GA20977@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005091520.27573.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] sysfs abi documentation
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

On Sunday 09 May 2010 15:08:35 Andrew Lunn wrote:
> I expect that we have a problem here. My guess is some of these files
> are going to have to move back into proc. Use sysfs for configuration,
> where only single values are needed, and put all the tables of
> originators, HNA etc back in proc where fancy formatting of data is
> not frowned upon.

Yes, you are probably right. Unfortunately, I'm not sure what is supposed to 
go where. AFAIK procfs is deprecated, sysfs does not seem suitable. Greg 
mentioned configfs, etc .. 
The idea was to document what we have & need and let them (Greg et al.) figure 
out what the best location might be to avoid investing more time & energy in 
the "wrong" virtual filesystem.  :-)

Cheers,
Marek
