Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 28 Feb 2010 18:19:06 +0800
References: <201002280430.09575.lindner_marek@yahoo.de>
	<1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
	<20100228093728.GF637@lunn.ch>
In-Reply-To: <20100228093728.GF637@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201002281819.07491.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: convert multiple /proc
	files to use sysfs
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

On Sunday 28 February 2010 17:37:28 Andrew Lunn wrote:
> With time i expect that bat_priv will gain many more members as global
> variables are replaced with variables per mesh. Rather than passing to
> functions a member, pass the pointer and let the function dereference
> it. I think it will make the APIs neater in the long run.

I agree - in the long run that will be better. I'll put that onto my todo 
list.

Regards,
Marek
