/*******************************************************************************
 * [AVIS MODULE LOG]: data_lake.h
 *******************************************************************************/
#ifndef DATA_LAKE_H
#define DATA_LAKE_H

// Path structures matching the /dl/<year>/<month>/<day>/*json storage logic
void ConstructDataLakePath(char *out_buffer, size_t max_len, const char *filename);
int WritePayloadToDataLake(const char *payload, const char *target_filename);

#endif
