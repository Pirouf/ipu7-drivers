// SPDX-License-Identifier: GPL-2.0-only
/*
 * Copyright (C) 2013 - 2025 Intel Corporation
 */

#include <uapi/linux/ipu-isys.h>

enum ipu7_isys_enum_link_state {
	IPU7_ISYS_LINK_STATE_DISABLED = 0,
	IPU7_ISYS_LINK_STATE_ENABLED = 1,
	IPU7_ISYS_LINK_STATE_DONE = 2,
	IPU7_ISYS_LINK_STATE_MD = 3,
	IPU7_ISYS_LINK_STATE_MAX,
};

static struct media_pad *other_pad(struct media_pad *pad);
bool has_src_pad_stream_active(struct v4l2_subdev *sd, u32 stream, u32 pad);
bool get_src_pad_by_src_stream(struct v4l2_subdev *sd, u32 stream, u32 *s_pad);

/* needed for callback */
extern int ipu7_isys_inherit_ctrls(struct ipu7_isys_video *av,
				  struct v4l2_subdev *sd, void *data);
extern int ipu7_isys_set_fmt_subdev(struct ipu7_isys_video *av,
				   struct v4l2_subdev *sd, void *data);
extern int ipu7_isys_enum_frameintervals_subdev(struct ipu7_isys_video *av,
					       struct v4l2_subdev *sd, void *data);
extern int ipu7_isys_enum_fmt_subdev(struct ipu7_isys_video *av,
				    struct v4l2_subdev *sd, void *data);
extern int ipu7_isys_enum_framesizes_subdev(struct ipu7_isys_video *av,
					   struct v4l2_subdev *sd, void *data);
extern int ipu7_isys_set_parm_subdev(struct ipu7_isys_video *av,
				    struct v4l2_subdev *sd, void *data);
extern int ipu7_isys_get_parm_subdev(struct ipu7_isys_video *av,
				    struct v4l2_subdev *sd, void *data);

extern int media_pipeline_enumerate_by_stream_cb(
		struct ipu7_isys_video *av,
		int (*cb_fn)(struct ipu7_isys_video *av,
					struct v4l2_subdev *sd,
					void *data),
		void *data);
