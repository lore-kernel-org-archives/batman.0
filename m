Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Tue, 3 Jan 2012 12:57:55 +0100
References: <1325374901-1620-1-git-send-email-sven@narfation.org>
	<1325374901-1620-4-git-send-email-sven@narfation.org>
In-Reply-To: <1325374901-1620-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201201031257.56077.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] vis: Update copyright years
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

Applied, thanks!

Cheers,
Elektra

Am Sonntag, 1. Januar 2012 00:41:40 schrieb Sven Eckelmann:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile      |    2 +-
>  allocate.c    |    2 +-
>  allocate.h    |    2 +-
>  hash.c        |    2 +-
>  hash.h        |    2 +-
>  list-batman.c |    2 +-
>  list-batman.h |    2 +-
>  udp_server.c  |    2 +-
>  vis-types.h   |    2 +-
>  vis.c         |    2 +-
>  vis.h         |    2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1804155..c4220f5 100755
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  #!/usr/bin/make -f
>  # -*- makefile -*-
>  #
> -# Copyright (C) 2006-2009 BATMAN contributors
> +# Copyright (C) 2006-2012 BATMAN contributors
>  #
>  # This program is free software; you can redistribute it and/or
>  # modify it under the terms of version 2 of the GNU General Public
> diff --git a/allocate.c b/allocate.c
> index 56f495f..5077531 100644
> --- a/allocate.c
> +++ b/allocate.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann, Marek Lindner
>   *
> diff --git a/allocate.h b/allocate.h
> index c3fe7df..167ab33 100644
> --- a/allocate.h
> +++ b/allocate.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann, Marek Lindner
>   *
> diff --git a/hash.c b/hash.c
> index e8c822f..2a9f557 100644
> --- a/hash.c
> +++ b/hash.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Simon Wunderlich, Marek Lindner
>   *
> diff --git a/hash.h b/hash.h
> index 443ef28..91ee7d8 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -1,5 +1,5 @@
>  /* 
> - * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Simon Wunderlich, Marek Lindner
>   *
> diff --git a/list-batman.c b/list-batman.c
> index 356c1eb..a0c2ad8 100644
> --- a/list-batman.c
> +++ b/list-batman.c
> @@ -1,5 +1,5 @@
>  /* 
> - * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Marek Lindner
>   *
> diff --git a/list-batman.h b/list-batman.h
> index 72d2ac4..ebff97c 100644
> --- a/list-batman.h
> +++ b/list-batman.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Marek Lindner
>   *
> diff --git a/udp_server.c b/udp_server.c
> index 8f9e664..1df497c 100644
> --- a/udp_server.c
> +++ b/udp_server.c
> @@ -1,7 +1,7 @@
>  /*
>   * udp_server.c
>   *
> - * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Marek Lindner
>   *
> diff --git a/vis-types.h b/vis-types.h
> index a4a35b2..c4c8068 100644
> --- a/vis-types.h
> +++ b/vis-types.h
> @@ -1,7 +1,7 @@
>  /*
>   * vis-types.h
>   *
> - * Copyright (C) 2006-2009 Marek Lindner:
> + * Copyright (C) 2006-2012 Marek Lindner:
>   *
>   *
>   * This program is free software; you can redistribute it and/or
> diff --git a/vis.c b/vis.c
> index 039bfa0..d92fbe8 100644
> --- a/vis.c
> +++ b/vis.c
> @@ -1,7 +1,7 @@
>  /*
>   * vis.c
>   *
> - * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Andreas Langer <an.langer@gmx.de>, Marek Lindner
>   * 
> diff --git a/vis.h b/vis.h
> index 74a3bd8..76ffdfb 100644
> --- a/vis.h
> +++ b/vis.h
> @@ -1,7 +1,7 @@
>  /*
>   * vis.h
>   *
> - * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
> + * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
>   *
>   * Andreas Langer <an.langer@gmx.de>, Marek Lindner
>   *
> 


-- 
Viral meme of radical freedom

The fact that you talk in your head doesn't mean that you think.

The best way to lose control over yourself is trying to control yourself.

Most people experience themselves as a voice in their head, telling them
who they are, what they think and what they have to do.

http://en.wikipedia.org/wiki/Meme
