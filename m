Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 28 Jan 2010 09:11:05 +0800
References: <4B60DB79.9020407@gmail.com>
In-Reply-To: <4B60DB79.9020407@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001280911.05308.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] git changes break OpenWRT package
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

On Thursday 28 January 2010 08:34:01 Gus Wirth wrote:
> Or since the kernel module can be built from source checked out from
> subversion, I guess the batman-adv package can be redone to only use the
> subversion code and not any maintenance code. Has anyone done this yet?
> I can't tell who created the original package so I suspect it is someone
> here.

Wow - you are quick!
We are currently reworking the OpenWRT source package to offer more 
functionality (e.g. downloading from different git branches), hence a few 
things changed. I'm still testing the latest changes to make sure everything 
works. I'll upload the new stuff in a couple of hours. If you can't wait that 
long here is the new URL:
http://git.open-mesh.org/snapshot/$git_hash/$any_name_you_want

Regards,
Marek
