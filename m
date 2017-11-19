Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:16 +0100
Message-Id: <20171119140517.24329-9-sven@narfation.org>
In-Reply-To: <20171119140517.24329-1-sven@narfation.org>
References: <20171119140517.24329-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Change batman_adv.h license
 to MIT
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
Cc: Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>, Matthias Schiffer <mschiffer@universe-factory.net>, Antonio Quartulli <a@unstable.cc>, Andrew Lunn <andrew@lunn.ch>

The ISC license is considered as not recommended in "Linux kernel licensing
rules". It should only be used for existing code or for importing code from
a different project with that license.

But the kernel still has the similar sounding MIT/Expat license under the
preferred licenses. Switching to this license for this relatively new file
should therefore allow batman-adv to better follow the new licensing rules.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
I would ask for Acked-by from following persons

Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Andrew Lunn <andrew@lunn.ch>

Please check

* https://www.gnu.org/licenses/license-list.html
* https://en.wikipedia.org/w/index.php?title=ISC_license&oldid=791486092
* https://en.wikipedia.org/w/index.php?title=MIT_License&oldid=809249689

For more information about these licenses.
---
 include/uapi/linux/batman_adv.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index fb453382..ae00c99c 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -1,19 +1,25 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: MIT */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
  *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
  */
 
 #ifndef _UAPI_LINUX_BATMAN_ADV_H_
-- 
2.11.0

