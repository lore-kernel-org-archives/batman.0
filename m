Return-Path: <onelektra@gmx.net>
Date: Thu, 21 Mar 2013 16:20:07 +0100
From: Elektra <onelektra@gmx.net>
Message-Id: <20130321162007.3e9836dbe3b881a8e2788741@gmx.net>
In-Reply-To: <20130321161629.3e471711506fc51ccac9c2fd@gmx.net>
References: <20130320175154.GT41481@l04.local>
 <3212285.GF4Btbehao@sven-desktop>
 <20130321161629.3e471711506fc51ccac9c2fd@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batmand: Either all or no source file
 should #define _GNU_SOURCE.
Reply-To: elektra@villagetelco.org,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Applied in commit 1e275d939d45ecc1d96957a353dc639d28aefb52
Author: Elektra Wagenrad <onelektra@gmx.net>
Date:   Thu Mar 21 15:57:45 2013 +0100

    Either all or no source file should #define _GNU_SOURCE.
    
    Thanks to Sven Eckelmann and Michael Tautschnig for reporting and fixing.
    
    Signed-off-by: Elektra Wagenrad <onelektra@gmx.net>

Thanks, everyone!

Cheers,
Elektra

> Subject: [PATCH] Either all or no source file should #define _GNU_SOURCE.
> 
> Thanks to Sven Eckelmann and Michael Tautschnig for reporting and fixes.
> 
> ---
>  Makefile            |    1 +
>  linux/route.c       |    1 -
>  posix/unix_socket.c |    1 -
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index fe1f094..ce1e198 100755
> --- a/Makefile
> +++ b/Makefile
> @@ -27,6 +27,7 @@ LINUX_OBJ =   linux/route.o linux/tun.o linux/kernel.o
>  
>  ifeq ($(UNAME),Linux)
>  OS_OBJ =       $(LINUX_OBJ) $(POSIX_OBJ)
> +CPPFLAGS +=    -D_GNU_SOURCE
>  endif
>  
>  OBJ = batman.o originator.o schedule.o list-batman.o allocate.o bitarray.o hash.o profile.o ring_buffer.o hna.o $(OS_OBJ)
> diff --git a/linux/route.c b/linux/route.c
> index 119ebb2..bceac95 100644
> --- a/linux/route.c
> +++ b/linux/route.c
> @@ -21,7 +21,6 @@
>  
>  
>  
> -#define _GNU_SOURCE
>  #include <sys/ioctl.h>
>  #include <arpa/inet.h>    /* inet_ntop() */
>  #include <errno.h>
> diff --git a/posix/unix_socket.c b/posix/unix_socket.c
> index 5bed217..02a0a3a 100644
> --- a/posix/unix_socket.c
> +++ b/posix/unix_socket.c
> @@ -21,7 +21,6 @@
>  
>  
>  
> -#define _GNU_SOURCE
>  #include <sys/time.h>
>  #include <stdio.h>
>  #include <fcntl.h>
> -- 
> 1.7.9.5


-- 
Elektra <onelektra@gmx.net>
