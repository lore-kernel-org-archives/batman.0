Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 28 May 2011 19:29:53 +0200
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105281929.54250.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] New translation table announcement
	mechanism patchset
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

On Wednesday 27 April 2011 23:35:02 Antonio Quartulli wrote:
> Patchset description:
> 1) Rename all the variables/functions/constants from hna to tt
> 2) Implement the new announcement mechanism
> 3) Implement the roaming optimisation
> 4) Protect by RCU the local and global table

I just applied the remaining 3 patches from your repository (the first one 
already entered the master branch a while ago). 
The corresponding commits are: 4dea027, cea194d & 7bad463.


> ** Patch 2/4 also introduces a dependency on the crc16 module since the new
> mechanism uses the crc16 computation function provided by this module. **

Guess we have to adjust our Kconfig file ? I'll modify the OpenWRT package to 
handle this dependency.

Thanks for your work,
Marek
