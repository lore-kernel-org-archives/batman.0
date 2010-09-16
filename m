Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Sep 2010 14:51:40 +0200
References: <1284589835-26617-1-git-send-email-sven.eckelmann@gmx.de>
	<1284629407-20394-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284629407-20394-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009161451.40470.arnd@arndb.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Mark debugfs files as nonseekable
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thursday 16 September 2010, Sven Eckelmann wrote:
> We don't allow to seek in the debugfs socket and log files. Thus we
> should mark the file descriptor as nonseekable.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks good. Do you want to merge it yourself? Otherwise I'll queue it up
in my tree.

	Arnd
