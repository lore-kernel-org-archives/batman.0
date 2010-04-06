Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Apr 2010 13:33:41 +0800
References: <1270345460-20555-1-git-send-email-sven.eckelmann@gmx.de>
	<1270398837-17050-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1270398837-17050-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004061333.41716.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Parse allowed settings for sysfs
	without whitespace before newline
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

On Monday 05 April 2010 00:33:57 Sven Eckelmann wrote:
> The current settings parser assumes that a newline is at the end of each
> line starting with "commands:". Luis de Bethencourt reported that this
> is a bad coding style and should be avoided.

Ok, I just verfied and committed your patch which allowed me to submit the 
remaining "whitespace" changes from Luis as well.

Thanks,
Marek
