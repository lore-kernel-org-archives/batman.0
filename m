Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 27 May 2014 19:11:54 +0200
References: <1401203055-22240-1-git-send-email-sven@narfation.org>
In-Reply-To: <1401203055-22240-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201405271911.54785.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batadv-vis: Avoid file handler leak
	after failed realloc
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

> The read_file function opens the file and thus has to close the filehandler
> after an realloc error. This was forgotten in the fix
> 0ad384e11ed039d4c3025a7eaf19fe6bcfd41acf ("batadv-vis: Avoid memory leak
> after failed realloc").
> 

Applied in revision 3b72283

Thanks,
    Simon
