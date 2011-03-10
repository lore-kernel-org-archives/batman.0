Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Mar 2011 09:28:22 +0100
References: <201103091748.32512.onelektra@gmx.net>
	<201103091804.55424.sven@narfation.org> <4D7883F8.7060303@it46.se>
In-Reply-To: <4D7883F8.7060303@it46.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201103100928.23396.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Patch] vis: Modified format of JSON output.
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
Cc: Alberto Escudero-Pascual <aep@it46.se>

On Thursday 10 March 2011 08:55:36 Alberto Escudero-Pascual wrote:
> * The patch fixes three issues
>  - Reporting of duplicated entries in the VIS output, this is fixed in
> trunk but not in vis.0.3.2
>  - Removed a gcc warning related to the use of chdir()
>  - Cleaned up the JSON output of vis
> 
> Our code is in SVN so I have not git-send-email magic :)

The point is not to make everybody use git - feel free to use other tools (git 
just makes it easy). But sending the patch to the list enables everybody to 
read & comment on the proposed patch and also allows a painless commit.

Broken spacing, broken line endings, patched files in remote SVNs, etc don't 
make reviewing the code a pleasure experience and are most likely to be 
ignored.

Regards,
Marek
