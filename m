Return-Path: <x@muc.ccc.de>
Message-ID: <4B763CF6.20302@muc.ccc.de>
Date: Sat, 13 Feb 2010 06:47:34 +0100
From: x@muc.ccc.de
MIME-Version: 1.0
References: <4B6F288E.8050406@muc.ccc.de> <20100212234532.GB24515@Sellars>
In-Reply-To: <20100212234532.GB24515@Sellars>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
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

hi!

Linus Lüssing wrote:
> Ehm, and another question. You said, that there's no bridging
> involved. However I see two mac addresses being announced by one
> of your laptops (B.A.T.M.A.N., Orig: Azurewav_8b:81:18
> (00:25:d3:8b:81:18)):
> - B.A.T.M.A.N. HNA: 0a:51:61:16:a1:51 (0a:51:61:16:a1:51)
> - B.A.T.M.A.N. HNA: 26:46:d1:f8:8c:54 (26:46:d1:f8:8c:54)
> Any idea where the first one might come from?

hmm, can't find any of these macs in the setup. i checked the prefixes, and both ouis are local. so i guess they're the macs of bat0 interfaces (and which changed over reboots). one of them probably the local interface, and the other one probably a batman-switched one of the other laptop's bat0 (i tested both with all nodes within each other's reach, and with two nodes not within each other's reach)?

regards,

	Chris
