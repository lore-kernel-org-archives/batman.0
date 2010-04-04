Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 4 Apr 2010 22:42:27 +0800
References: <1270341625-28764-1-git-send-email-luisbg@ubuntu.com>
	<201004041330.37112.sven.eckelmann@gmx.de>
	<g2o506b70dc1004040539weff4c04akcbde4ef62dcdaeb@mail.gmail.com>
In-Reply-To: <g2o506b70dc1004040539weff4c04akcbde4ef62dcdaeb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201004042242.27430.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] Staging: batman-adv: fix whitespace
	style issues
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Luis de Bethencourt <luisbg@ubuntu.com>

On Sunday 04 April 2010 20:39:49 Luis de Bethencourt wrote:
> Honestly, I don't understand the intention of the whitespaces you are
> talking about. Userspace applications have to split the string after
> each whitespace because there is a \n there, my fix just suggested to
> split the line before the whitespace since I see no need for it.
> 
> So am I missunderstanding and there is a need for that whitespace?
> Same question asked differently: Will there be any difference in the
> print out if the line is broken before the whitespace instead of
> after?

Let's take this string as an example:
"commands: enable, disable, 0, 1 \n"
The batctl code uses strchr() to jump to each whitespace location within the 
string and handle each word individually. By removing the last whitespace the 
code will not handle "1" because there is not more whitespace. See 
handle_sys_setting() in http://www.open-mesh.org/browser/trunk/batctl/sys.c

That is not tragic but the batctl code needs to be changed as well if the 
whitespace is removed.

Regards,
Marek
