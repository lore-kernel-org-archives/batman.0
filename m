Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 22 May 2011 11:41:56 +0200
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
	<1305980898-30494-6-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105221141.56870.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 06/14] batctl: Mark makefile targets
	without output as PHONY
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

On Saturday 21 May 2011 14:28:10 Sven Eckelmann wrote:
> Normally makefile targets should create an output with the same name as
> the target. It is necessary to mark them as PHONY to prevent that the
> virtual target like all, clean or install aren't executed when a file
> with the same name exists.

Applied in revision d487861.

Thanks,
Marek
